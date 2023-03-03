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
  one_pm: boolean = true;

  @IsBoolean()
  @IsOptional()
  three_pm: boolean = true;

  @IsBoolean()
  @IsOptional()
  six_pm: boolean = true;

  @IsBoolean()
  @IsOptional()
  eight_pm: boolean = true;

  @IsBoolean()
  @IsOptional()
  isedit: boolean = false;
}
