title:代理服务器
---
### proxy作为代理服务器，客户端请求进来，先对请求进行服务器内部搜索，看是否有符合请求的缓存，若有，直接返回，若无，则向上级proxy发送请求或者向internet抓包，再返回。   