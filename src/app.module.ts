import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { LoginModule } from './services/login/login.module';
import { AuthModule } from './services/auth/auth.module';
import { ScheduleModule } from '@nestjs/schedule';
import { bSignupModule } from './services/signup/signup.module';
import { TypeOrmModule } from '@nestjs/typeorm';
import { databaseConfig } from './config/database.config';
import { DatabaseModule } from './services/database/database.module';
import { APP_INTERCEPTOR } from '@nestjs/core';
import { ResponseInterceptor } from './interceptor/response_interceptor';
import { MenuModule } from './services/menu/menu.module';
import { purchaseModule } from './services/billpurchase/purchase.module';

@Module({
  imports: [
    LoginModule,
    AuthModule,
    ScheduleModule.forRoot(),
    TypeOrmModule.forRoot(databaseConfig),
    bSignupModule,
    DatabaseModule,
    MenuModule,
    purchaseModule,
  ],
  controllers: [AppController],
  providers: [{
    provide: APP_INTERCEPTOR,
    useClass: ResponseInterceptor,
  }, AppService],
})
export class AppModule { }
