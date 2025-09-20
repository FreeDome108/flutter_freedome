#!/bin/bash

# Flutter FreeDome Test Coverage Script
# This script runs all tests and generates comprehensive coverage reports

set -e

echo "🧪 Running Flutter FreeDome Test Suite with Coverage..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Clean previous coverage data
echo -e "${BLUE}📁 Cleaning previous coverage data...${NC}"
rm -rf coverage/
mkdir -p coverage/

# Run tests with coverage
echo -e "${BLUE}🔬 Running unit tests...${NC}"
flutter test test/unit/ --coverage --coverage-path=coverage/unit.lcov.info

echo -e "${BLUE}🎨 Running widget tests...${NC}"
flutter test test/widget/ --coverage --coverage-path=coverage/widget.lcov.info

echo -e "${BLUE}🔄 Running integration tests...${NC}"
flutter test test/integration/ --coverage --coverage-path=coverage/integration.lcov.info

# Combine coverage files
echo -e "${BLUE}📊 Combining coverage data...${NC}"
if command -v lcov >/dev/null 2>&1; then
    # Use lcov if available (more accurate)
    lcov --add-tracefile coverage/unit.lcov.info \
         --add-tracefile coverage/widget.lcov.info \
         --add-tracefile coverage/integration.lcov.info \
         --output-file coverage/lcov.info
    
    # Remove generated files and test files from coverage
    lcov --remove coverage/lcov.info \
         '*/test/*' \
         '*/generated/*' \
         '**/*.g.dart' \
         '**/*.freezed.dart' \
         '*/l10n/*' \
         --output-file coverage/lcov.info
else
    # Fallback: simple concatenation
    cat coverage/unit.lcov.info coverage/widget.lcov.info coverage/integration.lcov.info > coverage/lcov.info
fi

# Generate HTML report
echo -e "${BLUE}📋 Generating HTML coverage report...${NC}"
if command -v genhtml >/dev/null 2>&1; then
    genhtml coverage/lcov.info -o coverage/html --title "Flutter FreeDome Coverage Report"
    echo -e "${GREEN}✅ HTML report generated at: coverage/html/index.html${NC}"
else
    echo -e "${YELLOW}⚠️  genhtml not found. Install lcov for HTML reports.${NC}"
fi

# Generate coverage summary
echo -e "${BLUE}📈 Generating coverage summary...${NC}"
if command -v lcov >/dev/null 2>&1; then
    lcov --summary coverage/lcov.info > coverage/summary.txt
    
    # Extract coverage percentage
    COVERAGE=$(lcov --summary coverage/lcov.info 2>/dev/null | grep "lines" | grep -o '[0-9.]*%' | head -1)
    
    echo ""
    echo "=================================="
    echo -e "${GREEN}📊 COVERAGE SUMMARY${NC}"
    echo "=================================="
    cat coverage/summary.txt
    echo "=================================="
    
    # Coverage threshold check
    COVERAGE_NUM=$(echo $COVERAGE | sed 's/%//')
    THRESHOLD=80
    
    if (( $(echo "$COVERAGE_NUM >= $THRESHOLD" | bc -l) )); then
        echo -e "${GREEN}✅ Coverage ($COVERAGE) meets threshold ($THRESHOLD%)${NC}"
    else
        echo -e "${RED}❌ Coverage ($COVERAGE) below threshold ($THRESHOLD%)${NC}"
        exit 1
    fi
else
    echo -e "${YELLOW}⚠️  lcov not found. Install lcov for detailed coverage analysis.${NC}"
fi

# Test results summary
echo ""
echo "=================================="
echo -e "${GREEN}🎉 TEST EXECUTION COMPLETE${NC}"
echo "=================================="
echo -e "${BLUE}📁 Coverage files:${NC}"
echo "   - coverage/lcov.info (main coverage data)"
echo "   - coverage/html/index.html (HTML report)"
echo "   - coverage/summary.txt (text summary)"
echo ""
echo -e "${GREEN}✅ All tests passed with coverage analysis!${NC}"

# Optional: Open HTML report
if [[ "$1" == "--open" ]] && command -v open >/dev/null 2>&1; then
    echo -e "${BLUE}🌐 Opening coverage report in browser...${NC}"
    open coverage/html/index.html
fi
