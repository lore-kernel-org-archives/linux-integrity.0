Return-Path: <SRS0=ASXu=V6=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E8CC32750
	for <linux-integrity@archiver.kernel.org>; Fri,  2 Aug 2019 20:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D93E5205F4
	for <linux-integrity@archiver.kernel.org>; Fri,  2 Aug 2019 20:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388993AbfHBUUz (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 2 Aug 2019 16:20:55 -0400
Received: from mga03.intel.com ([134.134.136.65]:53713 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387790AbfHBUUz (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 2 Aug 2019 16:20:55 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Aug 2019 13:20:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,339,1559545200"; 
   d="scan'208";a="201782824"
Received: from psathya-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.36.242])
  by fmsmga002.fm.intel.com with ESMTP; 02 Aug 2019 13:20:52 -0700
Date:   Fri, 2 Aug 2019 23:20:50 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Alexander Steffen <Alexander.Steffen@infineon.com>
Cc:     linux-integrity@vger.kernel.org, tmaimon77@gmail.com,
        oshrialkoby85@gmail.com, Eyal.Cohen@nuvoton.com,
        Dan.Morav@nuvoton.com
Subject: Re: [RFC PATCH 2/2] tpm: Add tpm_tis_i2c backend for tpm_tis_core
Message-ID: <20190802201937.26xyr7y5vxc2kk7k@linux.intel.com>
References: <20190718170355.6464-1-Alexander.Steffen@infineon.com>
 <20190718170355.6464-3-Alexander.Steffen@infineon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190718170355.6464-3-Alexander.Steffen@infineon.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jul 18, 2019 at 07:03:55PM +0200, Alexander Steffen wrote:
> +static int tpm_tis_i2c_write_bytes(struct tpm_tis_data *data, u32 addr,
> +				   u16 len, const u8 *value)
> +{
> +	struct tpm_tis_i2c_phy *phy = to_tpm_tis_i2c_phy(data);
> +	int ret;
> +
> +	u8 locality[] = {
> +		0, // TPM_LOC_SEL
> +		addr >> 12, // locality
> +	};
> +
> +	if (phy->iobuf) {
> +		if (len > TPM_BUFSIZE - 1)
> +			return -EIO;
> +
> +		phy->iobuf[0] = address_to_register(addr);
> +		memcpy(phy->iobuf + 1, value, len);
> +
> +		{
> +			struct i2c_msg msgs[] = {
> +				{
> +					.addr = phy->i2c_client->addr,
> +					.len = sizeof(locality),
> +					.buf = locality,
> +				},
> +				{
> +					.addr = phy->i2c_client->addr,
> +					.len = len + 1,
> +					.buf = phy->iobuf,
> +				},
> +			};
> +
> +			ret = i2c_transfer(phy->i2c_client->adapter, msgs,
> +					   ARRAY_SIZE(msgs));
> +		}
> +	} else {
> +		u8 reg = address_to_register(addr);
> +
> +		struct i2c_msg msgs[] = {
> +			{
> +				.addr = phy->i2c_client->addr,
> +				.len = sizeof(locality),
> +				.buf = locality,
> +			},
> +			{
> +				.addr = phy->i2c_client->addr,
> +				.len = sizeof(reg),
> +				.buf = &reg,
> +			},
> +			{
> +				.addr = phy->i2c_client->addr,
> +				.len = len,
> +				.buf = (u8*)value,
> +				.flags = I2C_M_NOSTART,
> +			},
> +		};
> +
> +		ret = i2c_transfer(phy->i2c_client->adapter, msgs,
> +				   ARRAY_SIZE(msgs));
> +	}
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	usleep_range(250, 300); // wait default GUARD_TIME of 250µs

This does not look good. Would prefer to have named constants.

> +
> +	return 0;
> +}

You could probably simplify this by using branching for constructing
the message arrays and then use the same code path for transfer.

/Jarkko
