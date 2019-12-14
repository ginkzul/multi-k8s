docker build -t ginkzul/multi-client:latest -t ginkzul/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ginkzul/multi-server:latest -t ginkzul/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ginkzul/multi-worker:latest -t ginkzul/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push ginkzul/multi-client:latest
docker push ginkzul/multi-server:latest
docker push ginkzul/multi-worker:latest

docker push ginkzul/multi-client:$SHA
docker push ginkzul/multi-server:$SHA
docker push ginkzul/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ginkzul/multi-server:$SHA
kubectl set image deployments/client-deployment client=ginkzul/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ginkzul/multi-worker:$SHA