docker build -t vince15dk/complex-client:latest -t vince15dk/complex-client:$SHA -f ./client/Dockerfile ./client
docker build -t vince15dk/complex-server:latest -t vince15dk/complex-server:$SHA -f ./server/Dockerfile ./server
docker build -t vince15dk/complex-worker:latest -t vince15dk/complex-worker:$SHA -f ./worker/Dockerfile ./worker

docker push vince15dk/complex-client:latest
docker push vince15dk/complex-client:$SHA

docker push vince15dk/complex-server:latest
docker push vince15dk/complex-server:$SHA

docker push vince15dk/complex-worker:latest
docker push vince15dk/complex-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=vince15dk/complex-server:$SHA
kubectl set image deployments/client-deployment client=vince15dk/complex-client:$SHA
kubectl set image deployments/worker-deployment worker=vince15dk/complex-worker:$SHA

