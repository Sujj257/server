import { IsString, IsNotEmpty, IsInt, IsOptional } from 'class-validator';

export class SignupDto {

    @IsInt() @IsOptional()
    account_id!: number; 

    @IsString() @IsNotEmpty()
    username: string;

    @IsString() @IsNotEmpty()
    password: string;

    @IsString() @IsNotEmpty()
    privilage_level: string;

    @IsString() @IsNotEmpty()
    daily_limit: string;

    @IsString() @IsNotEmpty()
    weekly_limit: string;
}