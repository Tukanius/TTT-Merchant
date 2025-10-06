part '../../parts/user_models/user_card_request.dart';

class UserCardRequest {
  String? phone;
  String? registerNo;
  String? lastName;
  String? firstName;
  String? level2;
  String? level3;
  String? additionalInformation;
  String? requestStatus;
  String? passportAddress;
  UserCardRequest({
    this.phone,
    this.registerNo,
    this.lastName,
    this.firstName,
    this.level2,
    this.level3,
    this.additionalInformation,
    this.requestStatus,
    this.passportAddress,
  });
  static $fromJson(Map<String, dynamic> json) =>
      _$UserCardRequestFromJson(json);

  factory UserCardRequest.fromJson(Map<String, dynamic> json) =>
      _$UserCardRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UserCardRequestToJson(this);
}

// _id: Schema.Types.ObjectId;
//     name: string;
//     status: string;
//     isActive: boolean;
//     requestStatus: string;
//     requestStatusDate: Date;
//     createdBy: IUser;
//     appUser: IAppUser;
//     firstName: string;
//     lastName: string;
//     registerNo: string;
//     phone: string;
//     dataStatus: string; //new old
//     level2: IPlaceAddress | string,
//     level3: IPlaceAddress | string,
//     additionalInformation?: string | null,
//     addressString: string,
//     note?: string | null | "",
//     origin: string;
//     file: string;
//     cardType?: string | null; //VIRTUAL, PHYSICAL,
//     cardNo?: string | null;
//     createdAt: Date;
//     updatedBy: IUser;
//     deletedBy: IUser;
//     updatedAt: Date;
//     deletedAt: Date;
