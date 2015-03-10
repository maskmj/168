package {

import flash.display.Sprite;
import flash.events.Event;
import flash.events.ProgressEvent;
import flash.events.TimerEvent;
import flash.net.Socket;
import flash.text.TextField;
import flash.utils.Timer;

public class Main extends Sprite {

    protected var host:String;//s服务器
    protected var port:int;//端口
    private var socket:Socket;
    private var timer:Timer;
    public function Main() {
//        host = "120.39.244.173";
        host = "120.39.244.173";
        port = 8210;
//        port = 8310;
        init();
    }

    protected function init():void{
        timer = new Timer(3);
        timer.start();
        timer.addEventListener(TimerEvent.TIMER, onTimer);
        socket = new Socket();
        socket.addEventListener(ProgressEvent.SOCKET_DATA, onRecvData);
        socket.addEventListener(Event.CONNECT,onConnect);
        socket.addEventListener(Event.CLOSE , onClose);
    }

    private function onTimer(event:TimerEvent):void {
        if(socket.connected){
            //socket.writeByte(1);
            send("20,1|");
        }else{
            connect();
        }
    }

    private function onClose(event:Event):void {
        //断线
        trace("连接断开");
        connect();
    }

    private function onConnect(event:Event):void {
        trace("连接成功");
        send("45,174,1|");
    }

    private function onRecvData(event:ProgressEvent):void {
        //收取数据
        trace(socket.readMultiByte(socket.bytesAvailable,'utf-8'));
    }

    private function connect():void{
        socket.connect(host,port);
    }

    private function send(str:String):void{
        //发送数据
        if(socket.connected){
            socket.writeMultiByte(str,"utf-8");
            socket.flush();
        }

    }
}
}
