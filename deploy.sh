docker build -t lemix777/multi-client:latest -t lemix777/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t lemix777/multi-server:latest -t lemix777/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t lemix777/multi-worker:latest -t lemix777/multi-worker:$SHA -f ./worker/Dockerfile ./worker 
docker push lemix777/multi-client:latest
docker push lemix777/multi-server:latest
docker push lemix777/multi-worker:latest

docker push lemix777/multi-client:$SHA
docker push lemix777/multi-server:$SHA
docker push lemix777/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=lemix777/multi-server:$SHA
kubectl set image deployments/client-deployment client=lemix777/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=lemix777/multi-worker:$SHA