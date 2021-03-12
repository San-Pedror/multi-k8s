docker build -t migueltillart/multi-client:latest -t migueltillart/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t migueltillart/multi-server:latest -t migueltillart/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t migueltillart/multi-worker:latest -t migueltillart/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push migueltillart/multi-client:latest
docker push migueltillart/multi-server:latest
docker push migueltillart/multi-worker:latest

docker push migueltillart/multi-client:$SHA
docker push migueltillart/multi-server:$SHA
docker push migueltillart/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=migueltillart/multi-server:$SHA
kubectl set image deployments/client-deployment client=migueltillart/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=migueltillart/multi-worker:$SHA