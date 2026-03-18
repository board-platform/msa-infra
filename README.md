# Kubernetes Deployment (EKS)

Event-Driven Board System의 Kubernetes(EKS) 배포 구성을 관리하는 레포지토리입니다.

각 서비스(gateway, user, board, point)를 Deployment로 구성하고,  
Service를 통해 내부 및 외부 통신을 설정했습니다.

---

## Overview

본 레포지토리는 MSA 기반 게시판 시스템을 Kubernetes 환경에서 실행하기 위한  
배포 설정(Deployment, Service, ConfigMap, Secret)을 포함합니다.

---

## Architecture

[ Client ]
    ↓
[ LoadBalancer (gateway-service) ]
    ↓
[ Gateway Service ]
    ↓
[ user / board / point services ]

---

## Services

| Service          | Type          | Port            | Description        |
|------------------|---------------|-----------------|--------------------|
| gateway-service | LoadBalancer  | 8000 → 8080     | 외부 진입점        |
| user-service    | ClusterIP     | 8080 → 3000     | 사용자 서비스      |
| board-service   | ClusterIP     | 8081 → 8080     | 게시글 서비스      |
| point-service   | ClusterIP     | 8082 → 3000     | 포인트 서비스      |

---

## Key Design

- 서비스 간 통신은 Kubernetes Service DNS 기반으로 구성
- Pod 직접 접근이 아닌 Service 단위 통신 사용
- 환경 변수는 ConfigMap / Secret으로 분리
- Deployment 기반 Rolling Update 적용

---

## Directory Structure

k8s/
  ├── gateway/
  │   ├── deployment.yml
  │   └── service.yml
  ├── user/
  │   ├── deployment.yml
  │   └── service.yml
  ├── board/
  │   ├── deployment.yml
  │   └── service.yml
  └── point/
      ├── deployment.yml
      └── service.yml

---

## Deployment

### 1. ConfigMap / Secret 적용

kubectl apply -f config/

### 2. 서비스 배포

kubectl apply -f k8s/

### 3. 상태 확인

kubectl get pods  
kubectl get svc  

---

## Troubleshooting

- ConfigMap 변경 후 반영되지 않음  
  → rollout restart 필요

- 환경 변수 적용 실패  
  → Deployment에 envFrom 설정 누락 확인

- 서비스 간 통신 실패  
  → Service 이름 + Service Port로 호출해야 함

- Pod Pending 발생  
  → Node 리소스 부족 → NodeGroup 확장 또는 replicas 조정

---

## Future Improvements

- HPA (Horizontal Pod Autoscaler) 적용
- Ingress + 도메인 연결
- GitOps (ArgoCD) 도입
- 모니터링 (Prometheus / Grafana)