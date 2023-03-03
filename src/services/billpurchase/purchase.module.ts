import { Module } from '@nestjs/common';
import { purchaseService } from './purchase.service';
import { purchaseController } from './purchase.controller';
import { DatabaseModule } from '../database/database.module';

@Module({
  controllers: [purchaseController],
  imports:[DatabaseModule],
  providers: [purchaseService]
})
export class purchaseModule {}
