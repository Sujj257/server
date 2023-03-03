import { Body, Controller, Post, Req, UseGuards } from '@nestjs/common';
import { JwtAuthGuard } from '../auth/jwt-auth.guard';
import { SessionPayloadDto } from '../login/dto/jwttoken.dto';
import { SignupService } from './signup.service';
import { SignupDto } from './dto/signup.dto';

@UseGuards(JwtAuthGuard)
@Controller('signup')
export class SignupController {
  constructor(private readonly signupService: SignupService) {}
  @Post()
  signupAccount(@Body() body: SignupDto, @Req() req) {
    const sessionpayload = req.sessionpayload as SessionPayloadDto;
    body.account_id = sessionpayload.account_id;
    return this.signupService.createUser(body);
  }
}
