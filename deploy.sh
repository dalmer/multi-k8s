docker build -t dalmer/multi-client:latest -t dalmer/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t dalmer/multi-server:latest -t dalmer/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t dalmer/multi-worker:latest -t dalmer/multi-work:$SHA -f ./worker/Dockerfile ./worker

docker push dalmer/multi-client:latest 
docker push dalmer/multi-server:latest 
docker push dalmer/multi-worker:latest 

docker push dalmer/multi-client:$SHA 
docker push dalmer/multi-server:$SHA 
docker push dalmer/multi-worker:$SHA 

kubectl apply -f ./k8s

kubectl set image deployments/server-deployment server=dalmer/multi-server:$SHA
kubectl set image deployments/client-deployment client=dalmer/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=dalmer/multi-worker:$SHA
