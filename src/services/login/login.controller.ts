import { Controller, Post, Body, Get } from '@nestjs/common';
import { LoginService } from './login.service';
import { LoginDto } from './dto/login.dto';

@Controller('login')
export class LoginController {
  constructor(private readonly loginService: LoginService) {}

  @Post()
  login(@Body() body: LoginDto) {
    return this.loginService.checkuser(body);
  }

  @Get()
  getHello() {
    return { data: 'success' };
  }
}
