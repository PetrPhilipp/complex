docker build -t petrph/multi-client:latest -t petrph/multi-worker:$SHA -f ./client/Dockerfile ./client
docker build -t petrph/multi-server:latest -t petrph/multi-worker:$SHA -f ./server/Dockerfile ./server
docker build -t petrph/multi-worker:latest -t petrph/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push petrph/multi-client
docker push petrph/multi-server
docker push petrph/multi-worker

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=petrph/multi-client
kubectl set image deployments/server-deployment server=petrph/multi-server
kubectl set image deployments/worker-deployment worker=petrph/multi-worker