# Orchestrate

Claude Code Agent Teams를 사전 준비하여, **목표만 지정하면 즉시 팀을 구성**할 수 있는 베이스 프로젝트.

## 개요

이 프로젝트를 clone하고 목표(코드 기능 개발, 과제 제안서 작성 등)를 지정하면,
미리 정의된 에이전트 역할과 팀 구성 템플릿을 통해 Agent Team이 바로 시작됩니다.

## 요구사항

- Claude Code v2.1.32 이상
- `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS` 활성화 (`.claude/settings.json`에 포함됨)

## 프로젝트 구조

```
Orchestrate/
├── CLAUDE.md                    # 팀 운영 규칙 (Claude가 읽는 지침)
├── .claude/
│   ├── settings.json            # Agent Teams 활성화 + 권한 설정
│   └── agents/                  # 재사용 가능한 에이전트 역할 정의
│       ├── researcher.md        # 조사/분석 전문
│       ├── implementer.md       # 코드 구현 전문
│       ├── reviewer.md          # 코드 리뷰/품질 검증
│       ├── writer.md            # 문서/제안서 작성
│       ├── architect.md         # 설계/아키텍처
│       └── devils-advocate.md   # 반론/검증
├── templates/                   # 목표별 팀 구성 프롬프트
│   ├── feature.md               # 코드 기능 개발
│   ├── proposal.md              # 과제/제안서 작성
│   ├── review.md                # 코드 리뷰
│   ├── debug.md                 # 디버깅
│   └── research.md              # 기술 조사/비교 분석
└── scripts/
    ├── start.sh                 # 템플릿 프롬프트 안내
    └── clone-and-start.sh       # 새 프로젝트로 복사 + 초기화
```

## 사용 방법

### 방법 1: 직접 사용

```bash
cd Orchestrate
claude
```

Claude Code에서 원하는 템플릿의 프롬프트를 입력합니다.

### 방법 2: 새 프로젝트로 복사하여 사용

```bash
# 새 프로젝트로 복사
./scripts/clone-and-start.sh my-project feature

# 복사된 프로젝트에서 작업
cd my-project
claude
```

### 방법 3: 스크립트로 템플릿 확인

```bash
./scripts/start.sh feature    # 기능 개발 템플릿 확인
./scripts/start.sh proposal   # 제안서 템플릿 확인
```

## 템플릿 목록

| 템플릿 | 용도 | 기본 팀 규모 |
|--------|------|-------------|
| `feature` | 코드 기능 개발 | 5명 (설계자, 조사자, 구현자x2, 검증자) |
| `proposal` | 과제/제안서 작성 | 5명 (배경조사, 기술조사, 설계자, 집필자, 검증자) |
| `review` | 코드 리뷰 | 3명 (보안, 성능, 품질) |
| `debug` | 디버깅 | 3-4명 (가설별 조사자 + 수정자) |
| `research` | 기술 조사/비교 | 4명 (후보별 조사자 + 비평가) |

## 에이전트 역할

| 역할 | 설명 | 모델 |
|------|------|------|
| `researcher` | 조사/분석 전문 | Sonnet |
| `implementer` | 코드 구현 전문 | Sonnet |
| `reviewer` | 코드 리뷰/품질 검증 | Sonnet |
| `writer` | 문서/제안서 작성 | Sonnet |
| `architect` | 설계/아키텍처 | Opus |
| `devils-advocate` | 반론/검증 | Sonnet |

## 커스터마이즈

### 에이전트 추가

`.claude/agents/`에 새 `.md` 파일을 추가합니다:

```markdown
---
name: my-agent
description: 역할 설명
model: sonnet
tools:
  - Read
  - Edit
---

# My Agent

역할 지침...
```

### 템플릿 추가

`templates/`에 새 `.md` 파일을 추가하고 프롬프트 패턴을 작성합니다.

## 주의사항

- Agent Teams는 실험적 기능이며, 세션 재개(`/resume`) 시 팀원이 복원되지 않습니다
- 팀원 수가 많을수록 토큰 사용량이 선형적으로 증가합니다
- 같은 파일을 여러 팀원이 수정하면 충돌이 발생합니다 — 파일 영역을 분리하세요
- 작업 완료 후 반드시 리드에게 "팀 정리해줘"를 요청하세요
