import { ApiProperty } from '@nestjs/swagger';
import { IsString, IsNotEmpty, IsBoolean, IsNumber } from 'class-validator';

export class AppVersionDto {
  @IsNumber()
  @ApiProperty({
    description: 'event_id',
    example: 1,
  })
  event_id: number;

  @IsString()
  @IsNotEmpty()
  @ApiProperty({
    description: 'keyname',
    example: 'min_version',
  })
  keyname: string;

  @IsString()
  @IsNotEmpty()
  @ApiProperty({
    description: 'keyvalue',
    example: '20',
  })
  keyvalue: string;

  @IsBoolean()
  @IsNotEmpty()
  @ApiProperty({
    description: 'isedit',
    example: true,
  })
  isedit = false;
}
