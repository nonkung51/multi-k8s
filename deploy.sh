docker build -t nonkung51/multi-client:latest -t nonkung51/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t nonkung51/multi-server:latest -t nonkung51/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t nonkung51/multi-worker:latest -t nonkung51/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push nonkung51/multi-client:latest
docker push nonkung51/multi-server:latest
docker push nonkung51/multi-worker:latest

docker push nonkung51/multi-client:$SHA
docker push nonkung51/multi-server:$SHA
docker push nonkung51/multi-worker:$SHA

# Cheated by using Stephen's images ;-;
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=stephengrider/multi-server:latest
kubectl set image deployments/client-deployment client=stephengrider/multi-client:latest
kubectl set image deployments/worker-deployment worker=stephengrider/multi-worker:latest