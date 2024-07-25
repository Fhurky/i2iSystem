package SenderActorWithMain;

import akka.actor.AbstractActor;
import akka.actor.ActorSelection;
import akka.actor.ActorSystem;
import akka.pattern.Patterns;
import akka.util.Timeout;
import scala.concurrent.Await;
import scala.concurrent.Future;
import scala.concurrent.duration.Duration;

import java.util.concurrent.TimeUnit;

public class SenderActor extends AbstractActor {

    private final ActorSelection receiverActor;
    private final int disconnectWaitTime;
    public SenderActor() {
        ActorSystem system = getContext().getSystem();
        this.receiverActor = system.actorSelection("akka.tcp://ReceiverSystem@localhost:2553/user/receiver");
        this.disconnectWaitTime = 5;
    }
    @Override
    public Receive createReceive() {

        return receiveBuilder()
                .match(String.class, message -> {
                    Timeout timeout = new Timeout(Duration.create(disconnectWaitTime, TimeUnit.SECONDS));
                    Future<Object> future = Patterns.ask(receiverActor, message, timeout);
                    String result = (String) Await.result(future, timeout.duration());
                    System.out.println("Received response: " + result);
                })
                .build();
    }
}