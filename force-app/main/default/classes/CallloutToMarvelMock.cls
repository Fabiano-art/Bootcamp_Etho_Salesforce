public class CallloutToMarvelMock implements HttpCalloutMock {
	protected Integer code;
    protected String status;
    protected String body;
    
    public CallloutToMarvelMock(Integer httpCode){
        this.code = httpCode;
        if(httpCode == 200){
            this.status = 'OK';
            this.body = 'colcoar o json';
        }
        else {
            this.status = 'NOK';
            this.body = '';
        }
    }
    
    public HttpResponse respond(HttpRequest request){
        HttpResponse response = new HttpResponse();
        response.setBody(this.body);
        response.setStatusCode(this.code);
        response.setStatus(this.status);
        return response;
    }
}