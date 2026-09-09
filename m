Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971B246D2A3
	for <linux-integrity@vger.kernel.org>; Wed,  9 Sep 2026 23:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788995936; cv=none; b=HqTR0Mkn0O45fMFac5tyKjcWoLxSyHkoxldksJcIv40RDesUEOBFhtpA4v84vZernO8tQFD92AhNRGPvAL/UqjnvUCnSYADTTFKCYTSZy87dXvGaSnEAOwDFGMU8kx1rvF98PUmO2XtQutUAfTU3Nklxj2l4PSNtDcsyBXiUG0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788995936; c=relaxed/simple;
	bh=EFPcAPIn1zy/JSNEFFVGQG5ECrH0/fiy2wwp56/Tzfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DU717BKTDa3n1m481nB0mZS0QfvQXwgdNb8PbtUvs9b9erztHb1B/yHKBwNiPhv817u/n1a6de+ssqVWYY4f6Zzkb/6IByBVZKQ5OiLjxpezdlfNNJcx8oddCF18TyEwFwlLAPYvOwdcPR+BUUmIM1HJCuFLsEwBJvKTIfR5OnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V1dsPLwi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V1dsPLwi"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 183FC1F000FF;
	Wed,  9 Sep 2026 23:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788995933;
	bh=wVYSMz7VxoT9lOuJT96iRav098LZYkiJywXrhvjJb/E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=V1dsPLwicnlHQ92PYYfZc2kcpyyWsz6vahVtF9PwZ4br6S5LMEb/dMYjpXupTdYaH
	 9EYXKZSOL1CUboh77uDR+6RK2oDHGYU4e1XxNR+lARm8vEj6dnbpBzOOZBPA7bc7j0
	 N3ZPXEFzv7n+jpgCLgDO05D8pu0bvgFwEVLNXLzw103oADZ4XeSVqF2Wv+f/98tXTx
	 2pv2tAiAkl2FOO2VphNbTw/Ztys3aNWj8DgcjEgLHsPsIM5J117D1+ojiIDMpS1FkJ
	 b2GqD5aaexACB28KWO04LCF9ZNYMu6evu5zb1wDIOyLarXLnMmqGyrNkXP9bGy73bY
	 cr1wXzveyN7Yw==
Date: Thu, 10 Sep 2026 02:18:50 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v3] tpm: Call cmd_ready/go_idle for each command
 transmission
Message-ID: <aqHpWlTMteBGPmLf@kernel.org>
References: <20260901213723.3017371-1-mario.limonciello@amd.com>
 <apdX965qlXd3M-5i@kernel.org>
 <4ed5b724-02d9-411e-b393-d40fe9af40ad@amd.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ed5b724-02d9-411e-b393-d40fe9af40ad@amd.com>

On Wed, Sep 09, 2026 at 11:08:59AM -0500, Mario Limonciello wrote:
> 
> 
> On 9/1/26 17:55, Jarkko Sakkinen wrote:
> > On Tue, Sep 01, 2026 at 04:37:22PM -0500, Mario Limonciello wrote:
> > > Some TPM implementations, particularly fTPM using the CRB interface,
> > > require the TPM to transition through idle and ready states for each
> > > command rather than once per session.
> > > 
> > > The current implementation calls cmd_ready once during tpm_chip_start()
> > > and go_idle once during tpm_chip_stop(). For fTPM, when multiple commands
> > > are sent without per-command idle transitions, subsequent commands timeout
> > > as the TPM is waiting for the transition.
> > > 
> > > Fix this by calling cmd_ready before each command and go_idle on all exit
> > > paths in tpm_try_transmit(). For TPM implementations that don't require
> > > per-command transitions, the callbacks return immediately based on the
> > > start method.
> > > 
> > > Remove the now-redundant per-session calls from tpm_chip_start() and
> > > tpm_chip_stop() along with their helpers.
> > > 
> > > This resolves timeout errors during TPM initialization on systems where
> > > BIOS has already performed TPM startup.
> > > 
> > > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > > ---
> > > v3:
> > >   * Use __free() to clean up
> > > v2:
> > >   * Drop redundant calls
> > >   * Update commit message
> > > ---
> > >   drivers/char/tpm/tpm-chip.c      | 24 ------------------------
> > >   drivers/char/tpm/tpm-interface.c | 21 +++++++++++++++++++++
> > >   2 files changed, 21 insertions(+), 24 deletions(-)
> > > 
> > > diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> > > index 12b7394b34bdc..0be5dbfaa72eb 100644
> > > --- a/drivers/char/tpm/tpm-chip.c
> > > +++ b/drivers/char/tpm/tpm-chip.c
> > > @@ -66,22 +66,6 @@ static void tpm_relinquish_locality(struct tpm_chip *chip)
> > >   	chip->locality = -1;
> > >   }
> > > -static int tpm_cmd_ready(struct tpm_chip *chip)
> > > -{
> > > -	if (!chip->ops->cmd_ready)
> > > -		return 0;
> > > -
> > > -	return chip->ops->cmd_ready(chip);
> > > -}
> > > -
> > > -static int tpm_go_idle(struct tpm_chip *chip)
> > > -{
> > > -	if (!chip->ops->go_idle)
> > > -		return 0;
> > > -
> > > -	return chip->ops->go_idle(chip);
> > > -}
> > > -
> > >   static void tpm_clk_enable(struct tpm_chip *chip)
> > >   {
> > >   	if (chip->ops->clk_enable)
> > > @@ -116,13 +100,6 @@ int tpm_chip_start(struct tpm_chip *chip)
> > >   		}
> > >   	}
> > > -	ret = tpm_cmd_ready(chip);
> > > -	if (ret) {
> > > -		tpm_relinquish_locality(chip);
> > > -		tpm_clk_disable(chip);
> > > -		return ret;
> > > -	}
> > > -
> > >   	return 0;
> > >   }
> > >   EXPORT_SYMBOL_GPL(tpm_chip_start);
> > > @@ -137,7 +114,6 @@ EXPORT_SYMBOL_GPL(tpm_chip_start);
> > >    */
> > >   void tpm_chip_stop(struct tpm_chip *chip)
> > >   {
> > > -	tpm_go_idle(chip);
> > >   	tpm_relinquish_locality(chip);
> > >   	tpm_clk_disable(chip);
> > >   }
> > > diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> > > index f745a098908b3..8d434d7fa5bab 100644
> > > --- a/drivers/char/tpm/tpm-interface.c
> > > +++ b/drivers/char/tpm/tpm-interface.c
> > > @@ -19,6 +19,7 @@
> > >    * calls to msleep.
> > >    */
> > > +#include <linux/cleanup.h>
> > >   #include <linux/poll.h>
> > >   #include <linux/slab.h>
> > >   #include <linux/mutex.h>
> > > @@ -89,8 +90,16 @@ static bool tpm_transmit_completed(u8 status, struct tpm_chip *chip)
> > >   	return status_masked == chip->ops->req_complete_val;
> > >   }
> > > +static void tpm_go_idle(struct tpm_chip *chip)
> > > +{
> > > +	if (chip->ops->go_idle)
> > > +		chip->ops->go_idle(chip);
> > > +}
> > > +DEFINE_FREE(tpm_go_idle, struct tpm_chip *, if (_T) tpm_go_idle(_T))
> > > +
> > >   static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
> > >   {
> > > +	struct tpm_chip *chip_idle __free(tpm_go_idle) = NULL;
> > >   	struct tpm_header *header = buf;
> > >   	int rc;
> > >   	ssize_t len = 0;
> > > @@ -113,6 +122,18 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
> > >   		return -E2BIG;
> > >   	}
> > > +	if (chip->ops->cmd_ready) {
> > > +		rc = chip->ops->cmd_ready(chip);
> > > +		if (rc) {
> > > +			dev_err(&chip->dev,
> > > +				"%s: cmd_ready(): error %d\n", __func__, rc);
> > > +			return rc;
> > > +		}
> > > +	}
> > > +
> > > +	/* Ensure go_idle() is called on every exit path from here on. */
> > > +	chip_idle = chip;
> > > +
> > >   	rc = chip->ops->send(chip, buf, bufsiz, count);
> > >   	if (rc < 0) {
> > >   		if (rc != -EPIPE)
> > > -- 
> > > 2.43.0
> > > 
> > 
> > This is now much better as it addition adds better guarantees that
> > resources always get released after use no matter how this function
> > is modified later on.
> > 
> > Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> > 
> > BR, Jarkko
> 
> Thanks.  If no other concerns, can this be picked up now?
> 

Sorry for the delay, done

BR, Jarkko

