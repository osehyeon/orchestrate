#!/bin/bash
# Orchestrate - Agent Team 시작 스크립트
#
# 사용법:
#   ./scripts/start.sh <template> [project_path]
#
# 예시:
#   ./scripts/start.sh feature        # 기능 개발 팀 시작
#   ./scripts/start.sh proposal       # 제안서 작성 팀 시작
#   ./scripts/start.sh review         # 코드 리뷰 팀 시작
#   ./scripts/start.sh debug          # 디버깅 팀 시작
#   ./scripts/start.sh research       # 기술 조사 팀 시작

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
TEMPLATES_DIR="$PROJECT_ROOT/templates"

# 색상 정의
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_header() {
    echo ""
    echo -e "${BLUE}╔══════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║     Orchestrate - Agent Teams        ║${NC}"
    echo -e "${BLUE}╚══════════════════════════════════════╝${NC}"
    echo ""
}

print_usage() {
    echo -e "${YELLOW}사용법:${NC}"
    echo "  ./scripts/start.sh <template> [options]"
    echo ""
    echo -e "${YELLOW}사용 가능한 템플릿:${NC}"
    echo -e "  ${GREEN}feature${NC}    - 코드 기능 개발"
    echo -e "  ${GREEN}proposal${NC}   - 과제/제안서 작성"
    echo -e "  ${GREEN}review${NC}     - 코드 리뷰"
    echo -e "  ${GREEN}debug${NC}      - 디버깅/버그 수정"
    echo -e "  ${GREEN}research${NC}   - 기술 조사/비교 분석"
    echo ""
    echo -e "${YELLOW}예시:${NC}"
    echo "  ./scripts/start.sh feature"
    echo "  ./scripts/start.sh proposal"
}

# 인자 확인
if [ -z "$1" ]; then
    print_header
    print_usage
    exit 1
fi

TEMPLATE="$1"
TEMPLATE_FILE="$TEMPLATES_DIR/${TEMPLATE}.md"

# 템플릿 존재 확인
if [ ! -f "$TEMPLATE_FILE" ]; then
    echo -e "${RED}오류: 템플릿 '${TEMPLATE}'을 찾을 수 없습니다.${NC}"
    echo ""
    echo -e "사용 가능한 템플릿:"
    for f in "$TEMPLATES_DIR"/*.md; do
        basename "$f" .md
    done
    exit 1
fi

print_header
echo -e "${GREEN}템플릿:${NC} ${TEMPLATE}"
echo -e "${GREEN}파일:${NC} ${TEMPLATE_FILE}"
echo ""

# 템플릿 내용 표시
echo -e "${YELLOW}── 템플릿 프롬프트 ──${NC}"
echo ""
# 프롬프트 섹션만 추출 (``` 블록 안의 내용)
sed -n '/^## 프롬프트/,/^## /p' "$TEMPLATE_FILE" | sed '$d'
echo ""
echo -e "${YELLOW}────────────────────${NC}"
echo ""
echo -e "${BLUE}위 프롬프트의 {{변수}}를 실제 값으로 바꿔서 Claude Code에 입력하세요.${NC}"
echo ""
echo -e "Claude Code 시작:"
echo -e "  ${GREEN}cd ${PROJECT_ROOT} && claude${NC}"
echo ""
