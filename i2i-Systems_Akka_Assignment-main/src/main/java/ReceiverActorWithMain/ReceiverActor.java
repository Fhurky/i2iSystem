package ReceiverActorWithMain;

import akka.actor.AbstractActor;
public class ReceiverActor extends AbstractActor {

    @Override
    public Receive createReceive() {
        return receiveBuilder()
                .match(String.class, message -> {
                    System.out.println("Received message: "+ message);

                    getSender().tell("Hi from Actor 2", getSelf());
                })
                .build();
    }
}
