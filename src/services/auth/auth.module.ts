import { Module } from '@nestjs/common';
import { AuthService } from './auth.service';
import { JwtModule } from '@nestjs/jwt';
import { jwtConstants } from '../../config/auth.config';
import { JwtStrategy } from './jwt.strategy';
import { APP_INTERCEPTOR } from '@nestjs/core';
import { JwtInterceptor } from 'src/interceptor/request_interceptor';

@Module({
    imports: [
      JwtModule.register({
        secret: jwtConstants.secret,
        signOptions: { expiresIn: '1h' },
      }),
    ],
    providers: [AuthService, {
      provide: APP_INTERCEPTOR,
      useClass: JwtInterceptor,
    },JwtStrategy],
    exports: [AuthService],
  })
export class AuthModule {}
