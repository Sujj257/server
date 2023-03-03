import { Injectable } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { LoginDto } from '../login/dto/login.dto';
import { SessionPayloadDto } from '../login/dto/jwttoken.dto';

@Injectable()
export class AuthService {
    constructor(
        private readonly jwtService: JwtService
    ) { }

    async generateToken(payload: SessionPayloadDto) {
        return this.jwtService.sign(payload);
    }
}
