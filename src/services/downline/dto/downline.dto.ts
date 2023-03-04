import { ApiProperty } from '@nestjs/swagger';
import { IsNotEmpty, IsBoolean } from 'class-validator';

export class DownlineDto {
  @IsBoolean()
  @IsNotEmpty()
  @ApiProperty({
    description: 'show_my_acc',
    example: true,
  })
  show_my_acc = false;
}
