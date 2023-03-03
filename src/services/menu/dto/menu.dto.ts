import {
  IsString,
  IsNotEmpty,
  IsInt,
  IsBoolean,
  IsOptional,
  isNotEmpty,
} from 'class-validator';

export class MenuDto {
  @IsString()
  @IsNotEmpty()
  account_id: any;

  @IsBoolean()
  @IsOptional()
  one_pm = true;

  @IsBoolean()
  @IsOptional()
  three_pm = true;

  @IsBoolean()
  @IsOptional()
  six_pm = true;

  @IsBoolean()
  @IsOptional()
  eight_pm = true;

  @IsBoolean()
  @IsOptional()
  isedit = false;
}
