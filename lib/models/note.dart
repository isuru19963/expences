class Note{
    int _id;
    // int _originator;
    // String _originatorUnique;
    String _amount;
    String _email;
    String _transType;
    String _cardNo;
    String _payDate;
    String _note;
    String _payProof;
    String _empClient;
    String _client;
    String _employee;
    String _department;
    String _gst;
    String _traveling;
    String _entertainment;
    String _noneEntertainment;


    // String _filePath;
    // String _status;
    // String _create_date;

    Note(this._amount, this._email, this._transType, this._cardNo, this._payDate, this._payProof, this._empClient, this._department, this._gst, [this._client, this._employee, this._note, this._traveling, this._entertainment, this._noneEntertainment]);

    Note.withId(this._id, this._amount, this._email,this._transType, this._cardNo, this._payDate, this._empClient, this._department, this._gst, [this._client, this._employee, this._payProof,this._note,this._traveling, this._entertainment, this._noneEntertainment]);

    int get id => _id;
    // int get originator => _originator;
    // String get originatorUnique => _originatorUnique;
    String get email => _email;
    String get transType => _transType;
    String get amount => _amount;
    // String get paytype => _payType;
    String get cardNo => _cardNo;
    String get payDate => _payDate;
    String get note => _note;
    String get payProof => _payProof;
    String get empClient => _empClient;
    String get client => _client;
    String get employees => _employee;
    String get department => _department;
    String get gst => _gst;
    String get traveling => _traveling;
    String get entertainment => _entertainment;
    String get noneEntertainment => _noneEntertainment;
    // String get filePath => _filePath;
    // String get status => _status;
    // String get createDate => _create_date;

    // set originator(int neworiginator){
    //   this._originator = neworiginator;
    // }
    //
    // set originatorUnique(String newOriginatorUnique){
    //   if(newOriginatorUnique.length <= 255){
    //     this._originatorUnique = newOriginatorUnique;
    //   }
    // }

    set email(String newEmail){
        if(newEmail.length <= 255){
            this._email = newEmail;
        }
    }

    set amount(String newAmount){
        if(newAmount.length <= 255){
            this._amount = newAmount;
        }
    }

    set transType(String newTransType){
        if(newTransType.length <= 255){
            this._transType = newTransType;
        }
    }

    set cardNo(String newCardNo){
        if(newCardNo.length<= 255){
            this._cardNo = newCardNo;
        }
    }

    set payDate(String newPayDate){
        if(newPayDate.length <= 255){
            this._payDate = newPayDate;
        }
    }

    set note(String newNote){
        if(newNote.length <= 255){
            this._note = newNote;
        }
    }

    set payProof(String newPayProof){
        //if(newPayProof.length <= 255){
            this._payProof = newPayProof;
        //}
    }

    // set filePath(String newFilePath){
    //     if(newFilePath.length <= 255){
    //         this._payProof = newFilePath;
    //     }
    // }

    set empClient(String newEmpClient){
        if(newEmpClient.length <= 255){
            this._empClient = newEmpClient;
        }
    }

    set clients(String newClient){
        if(newClient.length <= 255){
            this._client = newClient;
        }
    }

    set employees(String newEmployee){
        if(newEmployee.length <= 255){
            this._employee = newEmployee;
        }
    }

    set department(String newDeparment){
        if(newDeparment.length <= 255){
            this._department = newDeparment;
        }
    }
    set gst(String newGst){
        if(newGst.length <= 255){
            this._gst = newGst;
        }
    }

    set traveling(String newTraveling){
        if(newTraveling.length <= 255){
            this._traveling = newTraveling;
        }
    }

    set entertainment(String newEntertainment){
        if(newEntertainment.length <= 255){
            this._entertainment = newEntertainment;
        }
    }

    set noneEntertainment(String newNoneEntertainment){
        if(newNoneEntertainment.length <= 255){
            this._noneEntertainment = newNoneEntertainment;
        }
    }

    set status(String newStatus){
        if(newStatus.length <= 255){
            this.status = newStatus;
        }
    }

    // set createDate(String newCreateDate){
    //   if(newCreateDate.length <= 255){
    //     this._create_date = newCreateDate;
    //   }
    // }

    //Create a map object - to convert Note object to mMap Object
    Map<String, dynamic> toMap(){

        //Instantiate a empty Map Object
        var map = Map<String, dynamic>();
        if(id != null){
            map['id'] = _id;
        }
        // map['originator'] = _originator;
        // map['originatorUnique'] = _originatorUnique;
        map['email'] = _email;
        map['transType'] = _transType;
        map['amount'] = _amount;
        // map['paytype'] = _payType;
        map['cardNo'] = _cardNo;
        map['payDate'] = _payDate;
        map['note'] = _note;
        map['payProof'] = _payProof;
        map['empClient'] = _empClient;
        map['client'] = _client;
        map['employee'] = _employee;
        map['department'] = _department;
        map['gst'] = _gst;
        map['traveling'] = _traveling;
        map['entertainment'] = _entertainment;
        map['noneEntertainment'] = _noneEntertainment;
        // map['filePath'] = _filePath;
        // map['status'] = _status;
        // map['createDate'] = _create_date;

        return map;
    }

    Note.fromMapObject(Map<String, dynamic> map){
        this._id = map['id'];
        // this._originator = map['originator'];
        // this._originatorUnique = map['originatorUnique'];
        this._email = map['email'];
        this._transType = map['transType'];
        this._amount = map['amount'];
        // this._payType = map['paytype'];
        this._cardNo = map['cardNo'];
        this._payDate = map['payDate'];
        this._note = map['note'];
        this._payProof = map['payProof'];
        this._empClient= map['empClient'];
        this._client = map['client'];
        this._employee = map['employee'];
        this._department = map['department'];
        this._gst = map['gst'];
        this._traveling = map['traveling'];
        this._entertainment = map['entertainment'];
        this._noneEntertainment = map['noneEntertainment'];
        // this._filePath = map['filePath'];
        // this._status = map['status'];
        // this._create_date = map['createDate'];
    }

}