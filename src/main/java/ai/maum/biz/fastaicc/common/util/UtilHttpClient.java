package ai.maum.biz.fastaicc.common.util;

import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpDelete;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.methods.HttpUriRequest;
import org.apache.http.impl.nio.client.CloseableHttpAsyncClient;
import org.apache.http.impl.nio.client.HttpAsyncClients;
import org.apache.http.message.BasicNameValuePair;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.Future;

public class UtilHttpClient {

    private static UtilHttpClient instance;

    private UtilHttpClient(){}

    public static UtilHttpClient getInstance()
    {
        if(instance == null) instance = new UtilHttpClient();
        return instance;
    }

    public HttpClientRes delete(String requestUrl, Map<String, String> paramMap) throws Exception
    {
        CloseableHttpAsyncClient client = HttpAsyncClients.createDefault();
        client.start();

        StringBuilder sbReqUrl = new StringBuilder(requestUrl);
        sbReqUrl.append("?");

        if(paramMap != null) {
            for(String key : paramMap.keySet()) {
                sbReqUrl.append(key).append("=").append(URLEncoder.encode(String.valueOf(paramMap.get(key)), "UTF-8")).append("&");
            }
        }

        HttpDelete httpDelete = new HttpDelete(sbReqUrl.toString());

        return execute(httpDelete);
    }

    public HttpClientRes post(String requestUrl, Map<String, String> paramMap) throws Exception
    {
        HttpPost httpPost = new HttpPost(requestUrl);

        List<NameValuePair> params = new ArrayList<>();
        for(String key : paramMap.keySet()) {
            params.add(new BasicNameValuePair(key, paramMap.get(key)));
        }

        httpPost.setEntity(new UrlEncodedFormEntity(params));
        return execute(httpPost);
    }

    private String extractResponseBodyFromInputStream(InputStream responseContent) throws IOException
    {
        StringBuilder responseBody;

        BufferedReader br = null;

        try {
            br = new BufferedReader( new InputStreamReader(responseContent) );
            String brLine;
            responseBody = new StringBuilder();

            while ((brLine = br.readLine()) != null) {
                responseBody.append(brLine);
            }

        } finally {
            if(br != null) br.close();
        }

        return responseBody.toString();
    }

    private HttpClientRes execute(HttpUriRequest httpMethod) throws Exception
    {
        CloseableHttpAsyncClient client = HttpAsyncClients.createDefault();
        client.start();

        Future<HttpResponse> future = client.execute(httpMethod, null);
        HttpResponse response = future.get();
        client.close();

        HttpClientRes res = new HttpClientRes();
        res.setStatusCode(response.getStatusLine().getStatusCode());
        res.setContent(extractResponseBodyFromInputStream(response.getEntity().getContent()));

        return res;
    }



}
