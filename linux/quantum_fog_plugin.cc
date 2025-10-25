// Flutter Plugin для Quantum Fog Engine
// Связывает Dart код с C++ реализацией через MethodChannel и EventChannel

#include <flutter_linux/flutter_linux.h>
#include <gtk/gtk.h>
#include <sys/utsname.h>
#include <cstring>
#include <memory>
#include <map>
#include <vector>

#include "quantum_fog_engine.h"

using namespace freedome::fog;

#define QUANTUM_FOG_PLUGIN(obj) \
  (G_TYPE_CHECK_INSTANCE_CAST((obj), quantum_fog_plugin_get_type(), \
                               QuantumFogPlugin))

struct _QuantumFogPlugin {
  GObject parent_instance;
  std::unique_ptr<QuantumFogEngine> engine;
  FlMethodChannel* method_channel;
  FlEventChannel* event_channel;
  FlEventSink* event_sink;
};

G_DEFINE_TYPE(QuantumFogPlugin, quantum_fog_plugin, g_object_get_type())

// ═══════════════════════════════════════════════════════════
// HELPER FUNCTIONS
// ═══════════════════════════════════════════════════════════

static FlValue* pattern_to_fl_value(const QuantumPattern& pattern) {
  g_autoptr(FlValue) map = fl_value_new_map();
  fl_value_set_string_take(map, "id", fl_value_new_int(pattern.id));
  fl_value_set_string_take(map, "face", fl_value_new_int(pattern.face));
  fl_value_set_string_take(map, "angle", fl_value_new_float(pattern.angle));
  fl_value_set_string_take(map, "azimuth", fl_value_new_float(pattern.azimuth));
  fl_value_set_string_take(map, "intensity", fl_value_new_float(pattern.intensity));
  fl_value_set_string_take(map, "phase_shift", fl_value_new_float(pattern.phase_shift));
  fl_value_set_string_take(map, "frequency", fl_value_new_float(pattern.frequency));
  return map;
}

static FlValue* state_to_fl_value(const FogSystemState& state) {
  g_autoptr(FlValue) map = fl_value_new_map();
  fl_value_set_string_take(map, "mode", fl_value_new_string(state.mode.c_str()));
  fl_value_set_string_take(map, "environment", fl_value_new_string(state.environment.c_str()));
  fl_value_set_string_take(map, "developer_mode", fl_value_new_bool(state.developer_mode));
  fl_value_set_string_take(map, "fog_density", fl_value_new_float(state.fog_density));
  fl_value_set_string_take(map, "visibility", fl_value_new_float(state.visibility));
  fl_value_set_string_take(map, "h2_production_rate", fl_value_new_float(state.h2_production_rate));
  fl_value_set_string_take(map, "h2_tank_pressure", fl_value_new_float(state.h2_tank_pressure));
  fl_value_set_string_take(map, "h2_tank_level", fl_value_new_float(state.h2_tank_level));
  fl_value_set_string_take(map, "power_consumption", fl_value_new_float(state.power_consumption));
  fl_value_set_string_take(map, "quantum_coherence", fl_value_new_float(state.quantum_coherence));
  fl_value_set_string_take(map, "space_quality", fl_value_new_float(state.space_quality));
  
  // Timestamp
  auto now = std::chrono::system_clock::now();
  auto time_t = std::chrono::system_clock::to_time_t(now);
  char buffer[100];
  strftime(buffer, sizeof(buffer), "%Y-%m-%dT%H:%M:%S", std::localtime(&time_t));
  fl_value_set_string_take(map, "timestamp", fl_value_new_string(buffer));
  
  return map;
}

static SystemMode string_to_mode(const gchar* mode_str) {
  std::string mode(mode_str);
  
  if (mode == "dome_fog_generation") return SystemMode::DOME_FOG_GENERATION;
  if (mode == "dome_fog_clearing") return SystemMode::DOME_FOG_CLEARING;
  if (mode == "dome_normalization") return SystemMode::DOME_SPACE_NORMALIZATION;
  if (mode == "dome_full") return SystemMode::DOME_FULL;
  if (mode == "vehicle_fog_tunnel") return SystemMode::VEHICLE_FOG_TUNNEL;
  if (mode == "dev_h2_harvest") return SystemMode::DEV_H2_HARVEST;
  if (mode == "dev_fog_generation") return SystemMode::DEV_FOG_GENERATION;
  
  return SystemMode::IDLE;
}

// ═══════════════════════════════════════════════════════════
// METHOD CHANNEL HANDLERS
// ═══════════════════════════════════════════════════════════

static FlMethodResponse* initialize_method(QuantumFogPlugin* self, FlValue* args) {
  const gchar* environment = fl_value_get_string(
      fl_value_lookup_string(args, "environment"));
  bool developer_mode = fl_value_get_bool(
      fl_value_lookup_string(args, "developer_mode"));
  
  Environment env = (strcmp(environment, "dome") == 0) 
      ? Environment::DOME 
      : Environment::VEHICLE;
  
  bool success = self->engine->Initialize(env, developer_mode);
  
  return FL_METHOD_RESPONSE(fl_method_success_response_new(
      fl_value_new_bool(success)));
}

static FlMethodResponse* start_mode_method(QuantumFogPlugin* self, FlValue* args) {
  const gchar* mode_str = fl_value_get_string(
      fl_value_lookup_string(args, "mode"));
  
  SystemMode mode = string_to_mode(mode_str);
  bool success = self->engine->StartMode(mode);
  
  return FL_METHOD_RESPONSE(fl_method_success_response_new(
      fl_value_new_bool(success)));
}

static FlMethodResponse* stop_all_method(QuantumFogPlugin* self) {
  bool success = self->engine->StopAll();
  
  return FL_METHOD_RESPONSE(fl_method_success_response_new(
      fl_value_new_bool(success)));
}

static FlMethodResponse* get_quantum_patterns_method(QuantumFogPlugin* self) {
  auto patterns = self->engine->GenerateQuantumPatterns();
  
  g_autoptr(FlValue) result = fl_value_new_list();
  for (const auto& pattern : patterns) {
    fl_value_append_take(result, pattern_to_fl_value(pattern));
  }
  
  return FL_METHOD_RESPONSE(fl_method_success_response_new(result));
}

static FlMethodResponse* emergency_h2_vent_method(QuantumFogPlugin* self) {
  self->engine->EmergencyH2Vent();
  
  return FL_METHOD_RESPONSE(fl_method_success_response_new(
      fl_value_new_bool(true)));
}

// ═══════════════════════════════════════════════════════════
// METHOD CHANNEL CALLBACK
// ═══════════════════════════════════════════════════════════

static void method_call_cb(FlMethodChannel* channel,
                           FlMethodCall* method_call,
                           gpointer user_data) {
  QuantumFogPlugin* self = QUANTUM_FOG_PLUGIN(user_data);
  
  const gchar* method = fl_method_call_get_name(method_call);
  FlValue* args = fl_method_call_get_args(method_call);
  
  g_autoptr(FlMethodResponse) response = nullptr;
  
  if (strcmp(method, "initialize") == 0) {
    response = initialize_method(self, args);
  } else if (strcmp(method, "startMode") == 0) {
    response = start_mode_method(self, args);
  } else if (strcmp(method, "stopAll") == 0) {
    response = stop_all_method(self);
  } else if (strcmp(method, "getQuantumPatterns") == 0) {
    response = get_quantum_patterns_method(self);
  } else if (strcmp(method, "emergencyH2Vent") == 0) {
    response = emergency_h2_vent_method(self);
  } else {
    response = FL_METHOD_RESPONSE(fl_method_not_implemented_response_new());
  }
  
  fl_method_call_respond(method_call, response, nullptr);
}

// ═══════════════════════════════════════════════════════════
// EVENT CHANNEL - STREAM STATE UPDATES
// ═══════════════════════════════════════════════════════════

static FlMethodErrorResponse* event_listen_cb(FlEventChannel* channel,
                                              FlValue* args,
                                              gpointer user_data) {
  QuantumFogPlugin* self = QUANTUM_FOG_PLUGIN(user_data);
  
  // Настройка callback для обновлений состояния
  self->engine->SetStateCallback([self](const FogSystemState& state) {
    if (self->event_sink) {
      g_autoptr(FlValue) event = state_to_fl_value(state);
      fl_event_sink_success(self->event_sink, event);
    }
  });
  
  return nullptr;  // Success
}

static FlMethodErrorResponse* event_cancel_cb(FlEventChannel* channel,
                                               FlValue* args,
                                               gpointer user_data) {
  QuantumFogPlugin* self = QUANTUM_FOG_PLUGIN(user_data);
  self->event_sink = nullptr;
  return nullptr;
}

// ═══════════════════════════════════════════════════════════
// PLUGIN SETUP
// ═══════════════════════════════════════════════════════════

static void quantum_fog_plugin_dispose(GObject* object) {
  QuantumFogPlugin* self = QUANTUM_FOG_PLUGIN(object);
  
  if (self->engine) {
    self->engine->StopAll();
    self->engine.reset();
  }
  
  G_OBJECT_CLASS(quantum_fog_plugin_parent_class)->dispose(object);
}

static void quantum_fog_plugin_class_init(QuantumFogPluginClass* klass) {
  G_OBJECT_CLASS(klass)->dispose = quantum_fog_plugin_dispose;
}

static void quantum_fog_plugin_init(QuantumFogPlugin* self) {
  self->engine = std::make_unique<QuantumFogEngine>();
}

void quantum_fog_plugin_register_with_registrar(FlPluginRegistrar* registrar) {
  QuantumFogPlugin* plugin = QUANTUM_FOG_PLUGIN(
      g_object_new(quantum_fog_plugin_get_type(), nullptr));
  
  // MethodChannel
  g_autoptr(FlStandardMethodCodec) codec = fl_standard_method_codec_new();
  plugin->method_channel = fl_method_channel_new(
      fl_plugin_registrar_get_messenger(registrar),
      "flutter_freedome/quantum_fog",
      FL_METHOD_CODEC(codec));
  fl_method_channel_set_method_call_handler(
      plugin->method_channel,
      method_call_cb,
      g_object_ref(plugin),
      g_object_unref);
  
  // EventChannel
  plugin->event_channel = fl_event_channel_new(
      fl_plugin_registrar_get_messenger(registrar),
      "flutter_freedome/quantum_fog/state",
      FL_METHOD_CODEC(codec));
  fl_event_channel_set_stream_handlers(
      plugin->event_channel,
      event_listen_cb,
      event_cancel_cb,
      g_object_ref(plugin),
      g_object_unref);
  
  g_object_unref(plugin);
}

