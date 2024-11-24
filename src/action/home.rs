use actix_web::{get, HttpResponse, Responder};

#[get("")]
pub async fn home() -> impl Responder {
    HttpResponse::Ok().body(format!(r#"<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>space-rework</title>
  </head>
  <body>
    <p>Lorem ipsum, dolor sit amet consectetur adipisicing elit. Sint consectetur doloribus fugit doloremque facere eaque laborum expedita perspiciatis nihil harum!</p>
    
  </body>
</html>
"#))
}