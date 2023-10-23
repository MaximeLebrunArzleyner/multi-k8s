docker build -t arzleyner/multi-client:latest -t arzleyner/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t arzleyner/multi-server:latest -t arzleyner/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t arzleyner/multi-worker:latest -t arzleyner/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push arzleyner/multi-client:latest
docker push arzleyner/multi-server:latest
docker push arzleyner/multi-worker:latest

docker push arzleyner/multi-client:$SHA
docker push arzleyner/multi-server:$SHA
docker push arzleyner/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=arzleyner/multi-server:$SHA
kubectl set image deployments/client-deployment client=arzleyner/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=arzleyner/multi-worker:$SHA