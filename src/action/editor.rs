use actix_web::{get, web, Result, Responder};
use serde::Serialize;

#[derive(Serialize)]
struct Info {
    name: String,
}

#[get("")]
pub async fn editor() -> Result<impl Responder> {
    let obj = Info {
        name: "coucou".to_string(),
    };
    Ok(web::Json(obj))
}