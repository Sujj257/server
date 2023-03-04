import { Module } from '@nestjs/common';
import { CommissionService } from './commission.service';
import { CommissionController } from './commission.controller';
import { DatabaseModule } from '../database/database.module';

@Module({
  controllers: [CommissionController],
  imports: [DatabaseModule],
  providers: [CommissionService],
})
export class CommissionModule {}
