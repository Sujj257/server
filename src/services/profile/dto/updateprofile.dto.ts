import { IsNotEmpty, IsString, IsBoolean } from 'class-validator';

export class UpdateProfileDto {
  @IsString()
  @IsNotEmpty()
  account_id: string;

  @IsString()
  password: string;

  @IsString()
  privilage_level: string;

  @IsString()
  daily_limit: string;

  @IsString()
  weekly_limit: string;

  @IsBoolean()
  block = false;
}
