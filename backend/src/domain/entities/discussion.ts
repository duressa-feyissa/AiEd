interface IDiscussion {
    id: string;
    dateTime: Date;
    userID: string;
    content: {
      type: string;
      image?: string;
      text?: string;
      equation?: string;
    };
    replies: IReply[];
  }
  
  interface IReply {
    id: string;
    dateTime: Date;
    userID: string;
    content: {
      type: string;
      image?: string;
      text?: string;
      equation?: string;
    };
  }
  {

interface    attemptedUsers {
    userId: string;
    attemptedAt: Date;
    userAnswer: {
      value: string;
    };
  }[];
  }