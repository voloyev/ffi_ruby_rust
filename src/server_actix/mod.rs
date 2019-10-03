use actix_web::{HttpRequest, HttpResponse, Responder};

pub fn index() -> impl Responder {
    HttpResponse::Ok().body("<h1>Hello world!</h1>")
}

pub fn greet(req: HttpRequest) -> impl Responder {
    let name = req.match_info().get("name").unwrap_or("World");
    format!("Hello {}!", &name)
}
