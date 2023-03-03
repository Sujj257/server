import { Module } from '@nestjs/common';
import { MenuService } from './menu.service';
import { MenuController } from './menu.controller';
import { DatabaseModule } from '../database/database.module';

@Module({
  controllers: [MenuController],
  imports:[DatabaseModule],
  providers: [MenuService]
})
export class MenuModule {}
