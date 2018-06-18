Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:48248 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933664AbeFRLFL (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 18 Jun 2018 07:05:11 -0400
Date: Mon, 18 Jun 2018 20:05:03 +0900
From: Wolfram Sang <wsa@the-dreams.de>
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Haavard Skinnemoen <hskinnemoen@gmail.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Guenter Roeck <linux@roeck-us.net>, Crt Mori <cmo@melexis.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Antti Palosaari <crope@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Michael Krufky <mkrufky@linuxtv.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-integrity@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: Re: [PATCH 01/11] i2c: add helpers for locking the I2C segment
Message-ID: <20180618110502.cb5s24srp4frahm6@ninjato>
References: <20180615101506.8012-1-peda@axentia.se>
 <20180615101506.8012-2-peda@axentia.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kyrdsz3663p2mr6a"
In-Reply-To: <20180615101506.8012-2-peda@axentia.se>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>


> +static inline void
> +i2c_lock_segment(struct i2c_adapter *adapter)
> +{
> +	i2c_lock_bus(adapter, I2C_LOCK_SEGMENT);
> +}
> +
> +static inline int
> +i2c_trylock_segment(struct i2c_adapter *adapter)
> +{
> +	return i2c_trylock_bus(adapter, I2C_LOCK_SEGMENT);
> +}
> +
> +static inline void
> +i2c_unlock_segment(struct i2c_adapter *adapter)
> +{
> +	i2c_unlock_bus(adapter, I2C_LOCK_SEGMENT);
> +}

I wonder if i2c_lock_segment() and i2c_lock_root_adapter() are really
more readable and convenient than i2c_lock_bus() with the flag. I think
the flags have speaking names, too.

Is that an idea to remove these functions altogether and start using
i2c_lock_bus()?



    [ Part 2, Application/PGP-SIGNATURE (Name: "signature.asc") 849 bytes. ]
    [ Unable to print this part. ]
