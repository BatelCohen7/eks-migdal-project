FROM nginx:alpine

COPY k8s/hello-world/index.html /usr/share/nginx/html/index.html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]