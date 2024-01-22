import { Injectable } from '@nestjs/common';
import { LoginDto } from './dto/login.dto';
import { AuthService } from '../auth/auth.service';
import { DatabaseService } from '../database/database.service';
import { SessionPayloadDto } from './dto/jwttoken.dto';
import { UserCheckerDto } from './dto/userchecker.dto';
import { Cryptography } from 'src/interceptor/encryption';

@Injectable()
export class LoginService {
  constructor(
    private readonly AuthService: AuthService,
    private readonly db: DatabaseService,
  ) {}

  async checkuser(payload: LoginDto) {
    try {
      const queryResponse = await this.db.executeFunc(
        'select lg_auth($1,$2,$3,$4,$5)',
        'lg_auth',
        [
          payload.username,
          payload.password,
          payload.ipaddress,
          payload.version,
          payload.admin_login,
        ],
      );
      if (queryResponse.error === null) {
        const sessionpayload = queryResponse.data as SessionPayloadDto;
        const token = await this.AuthService.generateToken(sessionpayload);
        return {
          data: { data: queryResponse.data, token: token },
          error: null,
        };
      } else {
        return queryResponse;
      }
    } catch (error) {
      throw error;
    }
  }

  async checker(payload: UserCheckerDto) {
    try {
      var response: boolean = false;
      const maintenance = await this.db.RawQuery(
        'select events::boolean from appconfig where event_name = $1',
        ['maintenance'],
      );
      if (
        payload.account_id.toString() != 'null' &&
        payload.account_id !== ''
      ) {
        const user_disabled = await this.db.RawQuery(
          'select user_disabled from user_login where account_id = $1',
          [parseInt(payload.account_id)],
        );
        if (
          user_disabled.user_disabled == false &&
          maintenance.events == false
        ) {
          response = false;
        } else {
          response = true;
        }
      } else {
        response = maintenance.events;
      }
      return { data: response, error: null };
    } catch (error) {
      throw error;
    }
  }
}
