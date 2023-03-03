import { Injectable } from '@nestjs/common';
import { LoginDto } from './dto/login.dto';
import { AuthService } from '../auth/auth.service';
import { DatabaseService } from '../database/database.service';
import { SessionPayloadDto } from './dto/jwttoken.dto';



@Injectable()
export class LoginService {
    constructor(private readonly AuthService: AuthService, private readonly db: DatabaseService) { }

    async checkuser(payload: LoginDto) {
        // await this.FirebaseService.sendToTopic('deepak','deepak','test');
        try {
            var queryResponse = await this.db.executeFunc('select lg_auth($1,$2,$3,$4)', 'lg_auth', [payload.username, payload.password, payload.ipaddress, payload.appversion]);
            if (queryResponse.error === null) {
                var sessionpayload = queryResponse.data as SessionPayloadDto;
                var token = await this.AuthService.generateToken(sessionpayload);
                var res = queryResponse.data;
                res.token = token;
                return { data: res, error: null };
            } else {
                return queryResponse;
            }
        } catch (error) {
            throw error;
        }
    }
}
