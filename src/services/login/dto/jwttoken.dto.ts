import { ApiProperty } from '@nestjs/swagger';
import { IsString, IsNotEmpty, IsInt } from 'class-validator';

export class SessionPayloadDto {
  @IsInt()
  @IsNotEmpty()
  account_id: number;

  @IsInt()
  @IsNotEmpty()
  session_id: number;

  @IsInt()
  @IsNotEmpty()
  privilage_level: number;

  @IsString()
  @IsNotEmpty()
  username: string;
}
