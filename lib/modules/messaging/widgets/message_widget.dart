import 'package:flutter/material.dart';
import 'package:shield/modules/messaging/enums/message_type.dart'
    as MessageTypeEnum;
import 'package:shield/modules/messaging/utils/date_util.dart';

import '../data/model/message.dart';

/**
 * Created by Abdullah on 1/9/24.
 */

class MessageWidget extends StatefulWidget {
  const MessageWidget({super.key, required this.message});

  final Message message;

  @override
  State<MessageWidget> createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<MessageWidget> {
  var mq;

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    bool isMe = widget.message.isOwn ?? false;
    return InkWell(child: isMe ? _ownMessage() : _othersMessage());
  }

  // sender or another user message
  Widget _othersMessage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //message content
        Flexible(
          child: Container(
              padding: EdgeInsets.all(widget.message.messageType ==
                      MessageTypeEnum.MessageType.IMAGE
                  ? mq.width * .03
                  : mq.width * .04),
              margin: EdgeInsets.symmetric(
                  horizontal: mq.width * .04, vertical: mq.height * .01),
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 221, 245, 255),
                  border: Border.all(color: Colors.lightBlue),
                  //making borders curved
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                      bottomRight: Radius.circular(30))),
              child: widget.message.messageType ==
                      MessageTypeEnum.MessageType.TEXT
                  ?
                  //show text
                  Text(
                      widget.message.message ?? '',
                      style:
                          const TextStyle(fontSize: 15, color: Colors.black87),
                    )
                  : Container()
              //show image
              /* ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              child: CachedNetworkImage(
                imageUrl: widget.message.message,
                fit: BoxFit.cover,
                placeholder: (context, url) => const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
                errorWidget: (context, url, error) =>
                const Icon(Icons.image, size: 70),
              ),
            ),


            */
              ),
        ),

        //message time
        Padding(
          padding: EdgeInsets.only(right: mq.width * .04),
          child: Text(
            DateUtil.getFormattedTime(
                context: context, time: widget.message.sent ?? ""),
            style: const TextStyle(fontSize: 13, color: Colors.black54),
          ),
        ),
      ],
    );
  }

  // our or user message
  Widget _ownMessage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //message time
        Row(
          children: [
            //for adding some space
            SizedBox(width: mq.width * .04),

            //double tick blue icon for message read
            if (widget.message.read != null && widget.message.read == 'true')
              const Icon(Icons.done_all_rounded, color: Colors.blue, size: 20),

            //for adding some space
            const SizedBox(width: 2),

            //sent time
            Text(
              DateUtil.getFormattedTime(
                  context: context, time: widget.message.sent),
              style: const TextStyle(fontSize: 13, color: Colors.black54),
            ),
          ],
        ),

        //message content
        Flexible(
          child: Container(
              padding: EdgeInsets.all(widget.message.messageType ==
                      MessageTypeEnum.MessageType.IMAGE
                  ? mq.width * .03
                  : mq.width * .04),
              margin: EdgeInsets.symmetric(
                  horizontal: mq.width * .04, vertical: mq.height * .01),
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 218, 255, 176),
                  border: Border.all(color: Colors.lightGreen),
                  //making borders curved
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30))),
              child: widget.message.messageType ==
                      MessageTypeEnum.MessageType.TEXT
                  ?
                  //show text
                  Text(
                      widget.message.message ?? '',
                      style:
                          const TextStyle(fontSize: 15, color: Colors.black87),
                    )
                  : Container()
              //show image
              /* ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              child: CachedNetworkImage(
                imageUrl: widget.message.message,
                placeholder: (context, url) => const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
                errorWidget: (context, url, error) =>
                const Icon(Icons.image, size: 70),
              ),
            ),*/
              ),
        ),
      ],
    );
  }
}
