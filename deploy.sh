docker build -t tvanderzwaag/multi-client:latest -t tvanderzwaag/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t tvanderzwaag/multi-server:latest -t tvanderzwaag/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t tvanderzwaag/multi-worker:latest -t tvanderzwaag/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push tvanderzwaag/multi-client:latest
docker push tvanderzwaag/multi-server:latest
docker push tvanderzwaag/multi-worker:latest

docker push tvanderzwaag/multi-client:$SHA
docker push tvanderzwaag/multi-server:$SHA
docker push tvanderzwaag/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=tvanderzwaag/multi-client:$SHA
kubectl set image deployments/server-deployment server=tvanderzwaag/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=tvanderzwaag/multi-worker:$SHA