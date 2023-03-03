import { Module } from '@nestjs/common';
import { LoginService } from './login.service';
import { LoginController } from './login.controller';
import { AuthModule } from '../auth/auth.module';
import { DatabaseModule } from '../database/database.module';

@Module({
  providers: [LoginService],
  imports: [AuthModule, DatabaseModule],
  controllers: [LoginController],
})
export class LoginModule {}
