docker build -t petrph/multi-client:latest -t petrph/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t petrph/multi-server:latest -t petrph/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t petrph/multi-worker:latest -t petrph/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push petrph/multi-client:latest
docker push petrph/multi-server:latest
docker push petrph/multi-worker:latest

docker push petrph/multi-client:$SHA
docker push petrph/multi-server:$SHA
docker push petrph/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=petrph/multi-client:$SHA
kubectl set image deployments/server-deployment server=petrph/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=petrph/multi-worker:$SHA