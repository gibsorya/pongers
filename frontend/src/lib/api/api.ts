import axios, { AxiosHeaders } from "axios";

interface IOptions {
  headers?: any;
}

const api = axios.create({
  baseURL: "/api"
});

const apiRequest = async (method: string, url: string, data?: any, opts?: IOptions) => {
  const headers = {
    "Content-Type": "application/json",
    ...opts?.headers
  }

  return await api.request({
    method,
    url,
    data,
    headers
  }).then(res => {
    return res.data;
  }).catch(err => {
    throw err;
  });
}

const get = async (url: string, request?: any, opts?: IOptions) => apiRequest("GET", url, request, opts);

const post = async (url: string, request?: any, opts?: IOptions) => apiRequest("POST", url, request, opts);

const put = async (url: string, request?: any, opts?: IOptions) => apiRequest("PUT", url, request, opts);

const del = async (url: string, request?: any, opts?: IOptions) => apiRequest("DELETE", url, request, opts);

const patch = async (url: string, request?: any, opts?: IOptions) => apiRequest("PATCH", url, request, opts);

const API = {
  get,
  post,
  put,
  delete: del,
  patch
}

export default API;