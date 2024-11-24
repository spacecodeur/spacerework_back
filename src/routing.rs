use actix_web::{web, Scope};

use crate::action::{editor::*, home::*};

pub fn routes() -> Scope {
    web::scope("")

    .service(web::scope("/")
        .service(home)
    )

    .service(web::scope("/editor")
        .service(editor)
    )
}
