import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'tax_lien_service.dart';

enum InvestmentRiskLevel { low, medium, high }
enum InvestmentGoal { quickReturn, longTerm, balanced }

class AIAnalysisResult {
  final double riskScore; // 0-100
  final double profitPotential; // 0-100
  final String recommendation;
  final List<String> pros;
  final List<String> cons;
  final InvestmentRiskLevel riskLevel;
  final double expectedROI;
  final int paybackMonths;

  AIAnalysisResult({
    required this.riskScore,
    required this.profitPotential,
    required this.recommendation,
    required this.pros,
    required this.cons,
    required this.riskLevel,
    required this.expectedROI,
    required this.paybackMonths,
  });
}

class AIInvestmentAdvisorService extends ChangeNotifier {
  final Random _random = Random();
  
  // Симуляция AI анализа налоговых закладных
  Future<AIAnalysisResult> analyzeTaxLien(TaxLien lien) async {
    // Имитация времени обработки AI
    await Future.delayed(const Duration(milliseconds: 1500));
    
    // Расчет риска на основе различных факторов
    double riskScore = _calculateRiskScore(lien);
    double profitPotential = _calculateProfitPotential(lien);
    InvestmentRiskLevel riskLevel = _determineRiskLevel(riskScore);
    
    return AIAnalysisResult(
      riskScore: riskScore,
      profitPotential: profitPotential,
      recommendation: _generateRecommendation(lien, riskScore, profitPotential),
      pros: _generatePros(lien, profitPotential),
      cons: _generateCons(lien, riskScore),
      riskLevel: riskLevel,
      expectedROI: _calculateExpectedROI(lien),
      paybackMonths: _calculatePaybackMonths(lien),
    );
  }

  double _calculateRiskScore(TaxLien lien) {
    double risk = 0.0;
    
    // Фактор 1: Отношение налога к оценочной стоимости
    double taxToValueRatio = lien.taxAmount / lien.assessedValue;
    if (taxToValueRatio > 0.05) risk += 20;
    else if (taxToValueRatio > 0.03) risk += 10;
    else risk += 5;
    
    // Фактор 2: Время до погашения
    int monthsToRedemption = lien.redemptionDeadline.difference(DateTime.now()).inDays ~/ 30;
    if (monthsToRedemption < 6) risk += 30;
    else if (monthsToRedemption < 12) risk += 15;
    else risk += 5;
    
    // Фактор 3: Округ (некоторые округа более рискованные)
    Map<String, double> countyRisk = {
      'Columbia': 15,
      'Dixie': 10,
      'Lafayette': 12,
      'Bradford': 20,
      'Polk': 8,
    };
    risk += countyRisk[lien.county] ?? 15;
    
    // Фактор 4: Оценочная стоимость (очень дорогие или очень дешевые более рискованные)
    if (lien.assessedValue > 200000 || lien.assessedValue < 50000) risk += 15;
    else risk += 5;
    
    // Добавляем немного случайности для реалистичности
    risk += _random.nextDouble() * 10;
    
    return risk.clamp(0, 100);
  }

  double _calculateProfitPotential(TaxLien lien) {
    double profit = 0.0;
    
    // Фактор 1: Процентная ставка
    profit += lien.interestRate * 3; // 18% = 54 points
    
    // Фактор 2: Отношение стоимости к налогу (больше шансов на получение имущества)
    double valueToTaxRatio = lien.assessedValue / lien.taxAmount;
    if (valueToTaxRatio > 100) profit += 25;
    else if (valueToTaxRatio > 50) profit += 15;
    else profit += 5;
    
    // Фактор 3: Локация (некоторые округа более прибыльные)
    Map<String, double> countyProfit = {
      'Polk': 20,
      'Columbia': 15,
      'Dixie': 18,
      'Lafayette': 12,
      'Bradford': 8,
    };
    profit += countyProfit[lien.county] ?? 10;
    
    // Фактор 4: Время до аукциона
    int daysToAuction = lien.auctionDate.difference(DateTime.now()).inDays;
    if (daysToAuction < 30) profit += 10;
    else if (daysToAuction < 90) profit += 5;
    
    return profit.clamp(0, 100);
  }

  InvestmentRiskLevel _determineRiskLevel(double riskScore) {
    if (riskScore < 30) return InvestmentRiskLevel.low;
    if (riskScore < 60) return InvestmentRiskLevel.medium;
    return InvestmentRiskLevel.high;
  }

  String _generateRecommendation(TaxLien lien, double riskScore, double profitPotential) {
    if (profitPotential > 70 && riskScore < 40) {
      return "🔥 СИЛЬНАЯ ПОКУПКА: Отличная возможность с высоким потенциалом прибыли и умеренным риском!";
    } else if (profitPotential > 60 && riskScore < 50) {
      return "✅ ПОКУПКА: Хорошая инвестиционная возможность с привлекательным соотношением риск/доходность.";
    } else if (profitPotential > 40 || riskScore < 35) {
      return "⚖️ РАССМОТРЕТЬ: Умеренная возможность. Изучите дополнительную информацию перед принятием решения.";
    } else if (riskScore > 70) {
      return "⚠️ ВЫСОКИЙ РИСК: Данная закладная имеет повышенные риски. Инвестируйте только если готовы к потерям.";
    } else {
      return "❌ НЕ РЕКОМЕНДУЮ: Низкий потенциал прибыли при значительных рисках.";
    }
  }

  List<String> _generatePros(TaxLien lien, double profitPotential) {
    List<String> pros = [];
    
    if (lien.interestRate >= 18) {
      pros.add("Высокая процентная ставка ${lien.interestRate}%");
    }
    
    double valueToTaxRatio = lien.assessedValue / lien.taxAmount;
    if (valueToTaxRatio > 50) {
      pros.add("Отличное соотношение стоимость/налог (${valueToTaxRatio.toStringAsFixed(1)}:1)");
    }
    
    if (lien.county == "Polk" || lien.county == "Dixie") {
      pros.add("Перспективный округ с хорошей ликвидностью");
    }
    
    if (lien.assessedValue > 100000 && lien.assessedValue < 200000) {
      pros.add("Оптимальная стоимость недвижимости для инвестиций");
    }
    
    int monthsToRedemption = lien.redemptionDeadline.difference(DateTime.now()).inDays ~/ 30;
    if (monthsToRedemption > 12) {
      pros.add("Достаточно времени для погашения");
    }
    
    if (pros.isEmpty) {
      pros.add("Стандартные условия налоговой закладной");
    }
    
    return pros;
  }

  List<String> _generateCons(TaxLien lien, double riskScore) {
    List<String> cons = [];
    
    double taxToValueRatio = lien.taxAmount / lien.assessedValue;
    if (taxToValueRatio > 0.04) {
      cons.add("Высокий размер налогового долга относительно стоимости");
    }
    
    int monthsToRedemption = lien.redemptionDeadline.difference(DateTime.now()).inDays ~/ 30;
    if (monthsToRedemption < 8) {
      cons.add("Короткий срок до погашения");
    }
    
    if (lien.county == "Bradford") {
      cons.add("Округ с повышенной конкуренцией на аукционах");
    }
    
    if (lien.assessedValue < 60000) {
      cons.add("Низкая стоимость недвижимости может указывать на проблемы");
    }
    
    if (lien.assessedValue > 250000) {
      cons.add("Высокая стоимость увеличивает финансовые риски");
    }
    
    if (cons.isEmpty && riskScore > 40) {
      cons.add("Умеренные риски, требующие дополнительного анализа");
    }
    
    return cons;
  }

  double _calculateExpectedROI(TaxLien lien) {
    // Базовая доходность от процентов
    double baseROI = lien.interestRate;
    
    // Бонус за соотношение стоимость/налог
    double valueToTaxRatio = lien.assessedValue / lien.taxAmount;
    if (valueToTaxRatio > 80) baseROI += 5;
    
    // Корректировка по округу
    Map<String, double> countyBonus = {
      'Polk': 2,
      'Dixie': 1,
      'Columbia': 0,
      'Lafayette': -1,
      'Bradford': -2,
    };
    baseROI += countyBonus[lien.county] ?? 0;
    
    return baseROI.clamp(5, 30);
  }

  int _calculatePaybackMonths(TaxLien lien) {
    // Среднее время погашения налоговых закладных
    int baseMonths = 8;
    
    // Корректировка по размеру долга
    if (lien.taxAmount > 2000) baseMonths += 2;
    if (lien.taxAmount < 1000) baseMonths -= 1;
    
    // Корректировка по округу
    Map<String, int> countyMonths = {
      'Polk': -1,
      'Dixie': 0,
      'Columbia': 1,
      'Lafayette': 1,
      'Bradford': 2,
    };
    baseMonths += countyMonths[lien.county] ?? 0;
    
    return baseMonths.clamp(3, 18);
  }

  // Получить персональные рекомендации на основе пользовательских предпочтений
  Future<List<TaxLien>> getPersonalizedRecommendations(
    List<TaxLien> availableLiens,
    InvestmentGoal goal,
    double maxInvestment,
    InvestmentRiskLevel riskTolerance,
  ) async {
    await Future.delayed(const Duration(milliseconds: 800));
    
    List<TaxLien> filtered = List.from(availableLiens);
    
    // Фильтрация по бюджету
    filtered = filtered.where((lien) => lien.taxAmount <= maxInvestment).toList();
    
    // Анализ каждой закладной
    List<MapEntry<TaxLien, AIAnalysisResult>> analyzed = [];
    for (TaxLien lien in filtered) {
      AIAnalysisResult analysis = await analyzeTaxLien(lien);
      
      // Фильтрация по риск-толерантности
      bool riskMatch = false;
      switch (riskTolerance) {
        case InvestmentRiskLevel.low:
          riskMatch = analysis.riskScore < 40;
          break;
        case InvestmentRiskLevel.medium:
          riskMatch = analysis.riskScore < 70;
          break;
        case InvestmentRiskLevel.high:
          riskMatch = true;
          break;
      }
      
      if (riskMatch) {
        analyzed.add(MapEntry(lien, analysis));
      }
    }
    
    // Сортировка по целям инвестирования
    analyzed.sort((a, b) {
      switch (goal) {
        case InvestmentGoal.quickReturn:
          return a.value.paybackMonths.compareTo(b.value.paybackMonths);
        case InvestmentGoal.longTerm:
          return b.value.expectedROI.compareTo(a.value.expectedROI);
        case InvestmentGoal.balanced:
          double scoreA = (a.value.profitPotential - a.value.riskScore) / 2;
          double scoreB = (b.value.profitPotential - b.value.riskScore) / 2;
          return scoreB.compareTo(scoreA);
      }
    });
    
    return analyzed.take(5).map((entry) => entry.key).toList();
  }

  // Получить обзор рынка
  Future<MarketInsights> getMarketInsights(List<TaxLien> availableLiens) async {
    await Future.delayed(const Duration(milliseconds: 600));
    
    if (availableLiens.isEmpty) {
      return MarketInsights(
        averageInterestRate: 0,
        averageTaxAmount: 0,
        totalAvailable: 0,
        hotCounties: [],
        marketTrend: "Нет данных",
        recommendedAction: "Дождитесь появления новых возможностей",
      );
    }
    
    double avgInterestRate = availableLiens
        .map((l) => l.interestRate)
        .reduce((a, b) => a + b) / availableLiens.length;
    
    double avgTaxAmount = availableLiens
        .map((l) => l.taxAmount)
        .reduce((a, b) => a + b) / availableLiens.length;
    
    // Подсчет закладных по округам
    Map<String, int> countyCount = {};
    for (TaxLien lien in availableLiens) {
      countyCount[lien.county] = (countyCount[lien.county] ?? 0) + 1;
    }
    
    List<String> hotCounties = countyCount.entries
        .where((entry) => entry.value >= 2)
        .map((entry) => entry.key)
        .toList();
    
    String trend = _analyzeTrend(availableLiens);
    String action = _getRecommendedAction(availableLiens, avgInterestRate);
    
    return MarketInsights(
      averageInterestRate: avgInterestRate,
      averageTaxAmount: avgTaxAmount,
      totalAvailable: availableLiens.length,
      hotCounties: hotCounties,
      marketTrend: trend,
      recommendedAction: action,
    );
  }

  String _analyzeTrend(List<TaxLien> liens) {
    // Простой анализ тренда на основе доступных данных
    double avgValue = liens.map((l) => l.assessedValue).reduce((a, b) => a + b) / liens.length;
    
    if (avgValue > 150000) {
      return "📈 Рынок премиум-недвижимости активен";
    } else if (avgValue > 100000) {
      return "⚖️ Сбалансированный рынок со средними ценами";
    } else {
      return "📉 Преобладают бюджетные варианты";
    }
  }

  String _getRecommendedAction(List<TaxLien> liens, double avgRate) {
    if (liens.length < 3) {
      return "⏳ Подождите появления новых возможностей";
    } else if (avgRate >= 18) {
      return "🚀 Отличное время для инвестиций - высокие ставки!";
    } else {
      return "✅ Хорошее время для селективных инвестиций";
    }
  }
}

class MarketInsights {
  final double averageInterestRate;
  final double averageTaxAmount;
  final int totalAvailable;
  final List<String> hotCounties;
  final String marketTrend;
  final String recommendedAction;

  MarketInsights({
    required this.averageInterestRate,
    required this.averageTaxAmount,
    required this.totalAvailable,
    required this.hotCounties,
    required this.marketTrend,
    required this.recommendedAction,
  });
}
