import { Module } from '@nestjs/common';
import { ManageAppService } from './manage_app.service';
import { ManageAppController } from './manage_app.controller';
import { DatabaseModule } from '../database/database.module';

@Module({
  providers: [ManageAppService],
  imports: [DatabaseModule],
  controllers: [ManageAppController]
})
export class ManageAppModule { }
