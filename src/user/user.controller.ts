import { Controller, Get } from '@nestjs/common';

@Controller('user')
export class UserController {

    @Get('/user')
    async user() {

        return "this is the user"
    }
}
