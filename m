Return-Path: <SRS0=Ndpk=OK=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9BA9C04EB8
	for <linux-integrity@archiver.kernel.org>; Sat,  1 Dec 2018 03:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81F772145D
	for <linux-integrity@archiver.kernel.org>; Sat,  1 Dec 2018 03:02:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81F772145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-integrity-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbeLAON1 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Sat, 1 Dec 2018 09:13:27 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:58572 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbeLAON1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 1 Dec 2018 09:13:27 -0500
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 0FEB572CA65;
        Sat,  1 Dec 2018 06:01:59 +0300 (MSK)
Received: from sole.flsd.net (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id EDCCC4A4A29;
        Sat,  1 Dec 2018 06:01:58 +0300 (MSK)
Date:   Sat, 1 Dec 2018 06:01:58 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v2 5/7] ima-evm-utils: Preload OpenSSL engine via
 '--engine' option
Message-ID: <20181201030158.q6bck2wwtkezzpns@sole.flsd.net>
References: <20181128200610.21214-1-vt@altlinux.org>
 <20181128200610.21214-5-vt@altlinux.org>
 <1543605694.4216.72.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1543605694.4216.72.camel@linux.ibm.com>
User-Agent: NeoMutt/20171215-106-ac61c7
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Nov 30, 2018 at 02:21:34PM -0500, Mimi Zohar wrote:
> On Wed, 2018-11-28 at 23:06 +0300, Vitaly Chikunov wrote:
> 
> > @@ -1773,6 +1776,7 @@ static char *get_password(void)
> >  int main(int argc, char *argv[])
> >  {
> >  	int err = 0, c, lind;
> > +	ENGINE *eng = NULL;
> > 
> >  	g_argv = argv;
> >  	g_argc = argc;
> > @@ -1883,6 +1887,18 @@ int main(int argc, char *argv[])
> >  		case 138:
> >  			measurement_list = 1;
> >  			break;
> > +		case 139: /* --engine e */
> > +			eng = ENGINE_by_id(optarg);
> 
> The usage is only adding "--engine e" support. šEither change the
> usage or add a test to verify the argument.

Could you elaborate what I should do? I didn't understand your
suggestion.  User should be able to specify anything as engine name and
it is tested by ENGINE_by_id call. Also, usage implies that it would
load engine with the name e.


> 
> 
> > +			if (!eng) {
> > +				log_err("engine %s isn't available\n", optarg);
> > +				ERR_print_errors_fp(stderr);
> > +			} else if (!ENGINE_init(eng)) {
> > +				log_err("engine %s init failed\n", optarg);
> > +				ERR_print_errors_fp(stderr);
> > +				ENGINE_free(eng);
> > +				eng = NULL;
> > +			}
> > +			break;
> >  		case 140: /* --xattr-user */
> >  			xattr_ima = "user.ima";
> >  			xattr_evm = "user.evm";
