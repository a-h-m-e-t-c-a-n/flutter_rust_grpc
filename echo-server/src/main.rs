use tonic::{transport::Server, Request, Response, Status};

use echo_grpc::echo_server:: {Echo, EchoServer};
use echo_grpc::{EchoReply, EchoRequest};

use std::net::{IpAddr, Ipv4Addr, SocketAddr};

pub mod echo_grpc {
    tonic::include_proto!("echopackage"); 
}

#[derive(Debug, Default)]
pub struct EchoImpl {}

#[tonic::async_trait]
impl Echo for EchoImpl {
    async fn do_echo(&self,request: Request<EchoRequest>,) -> Result<Response<EchoReply>,Status> { 
        println!("Got a request: {:?}", request);
        let reply = echo_grpc::EchoReply {
            reply_content: request.into_inner().source_content,
        };
        Ok(Response::new(reply)) 
    }
}


#[tokio::main]
async fn main() -> Result<(), Box<dyn std::error::Error>> {
   // let addr = "[::1]:50051".parse()?;
    let socket = SocketAddr::new(IpAddr::V4(Ipv4Addr::new(0, 0, 0, 0)), 50051);

    //println!("{0:?}",addr);
    let echoservice = EchoImpl::default();

    Server::builder()
        .add_service(EchoServer::new(echoservice))
        .serve(socket)
        .await?;

    Ok(())
}